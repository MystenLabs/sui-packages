module 0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::platinum_controller_pass {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PassRegistry has key {
        id: 0x2::object::UID,
        total_passes: u64,
        is_open: bool,
    }

    struct PlatinumPass has store, key {
        id: 0x2::object::UID,
        serial: u64,
        holder: address,
        valid_until_epoch: u64,
        image_url: 0x2::url::Url,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PassRegistry{
            id           : 0x2::object::new(arg0),
            total_passes : 0,
            is_open      : true,
        };
        0x2::transfer::share_object<PassRegistry>(v1);
    }

    public fun is_active(arg0: &PlatinumPass, arg1: u64) : bool {
        arg0.valid_until_epoch > arg1
    }

    public entry fun mint(arg0: &mut PassRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0);
        arg0.total_passes = arg0.total_passes + 1;
        let v0 = PlatinumPass{
            id                : 0x2::object::new(arg2),
            serial            : arg0.total_passes,
            holder            : 0x2::tx_context::sender(arg2),
            valid_until_epoch : 0x2::tx_context::epoch(arg2) + 30,
            image_url         : 0x2::url::new_unsafe_from_bytes(b"https://misomosa.gg/nft/platinum-pass.png"),
        };
        0x2::transfer::public_transfer<PlatinumPass>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun price() : u64 {
        10000000000
    }

    public entry fun renew(arg0: &mut PlatinumPass, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0);
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = if (arg0.valid_until_epoch > v0) {
            arg0.valid_until_epoch
        } else {
            v0
        };
        arg0.valid_until_epoch = v1 + 30;
    }

    public entry fun set_open(arg0: &AdminCap, arg1: &mut PassRegistry, arg2: bool) {
        arg1.is_open = arg2;
    }

    public fun treasury() : address {
        @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0
    }

    // decompiled from Move bytecode v7
}

