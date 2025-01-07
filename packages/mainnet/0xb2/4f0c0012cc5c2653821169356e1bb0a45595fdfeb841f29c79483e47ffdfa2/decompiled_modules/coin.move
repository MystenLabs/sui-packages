module 0xb24f0c0012cc5c2653821169356e1bb0a45595fdfeb841f29c79483e47ffdfa2::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<COIN>,
        mintsupply: u64,
        maxsupply: u64,
        mintaddr: address,
        max: u64,
        min: u64,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 4, b"LESTER", b"LESTER", b"$LITECOIN and $DOGE are very good friends", 0x1::option::some<0x2::url::Url>(0xb24f0c0012cc5c2653821169356e1bb0a45595fdfeb841f29c79483e47ffdfa2::icon::get_icon_url()), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        let v2 = Treasury<COIN>{
            id          : 0x2::object::new(arg1),
            treasuryCap : v0,
            mintsupply  : 0,
            maxsupply   : 210000000000,
            mintaddr    : 0x2::tx_context::sender(arg1),
            max         : 100,
            min         : 30,
        };
        0x2::transfer::share_object<Treasury<COIN>>(v2);
    }

    public entry fun mint(arg0: &mut Treasury<COIN>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::digest(arg2);
        let v2 = 0x2::bcs::to_bytes<address>(&v0);
        let v3 = arg0.min + ((((*0x1::vector::borrow<u8>(v1, 0) as u64) << 56 | (*0x1::vector::borrow<u8>(v1, 1) as u64) << 48 | (*0x1::vector::borrow<u8>(v1, 2) as u64) << 40 | (*0x1::vector::borrow<u8>(v1, 3) as u64) << 32) ^ ((*0x1::vector::borrow<u8>(&v2, 0) as u64) << 56 | (*0x1::vector::borrow<u8>(&v2, 1) as u64) << 48 | (*0x1::vector::borrow<u8>(&v2, 2) as u64) << 40 | (*0x1::vector::borrow<u8>(&v2, 3) as u64) << 32 | (*0x1::vector::borrow<u8>(&v2, 4) as u64) << 24 | (*0x1::vector::borrow<u8>(&v2, 5) as u64) << 16 | (*0x1::vector::borrow<u8>(&v2, 6) as u64) << 8 | (*0x1::vector::borrow<u8>(&v2, 7) as u64))) + ((*0x1::vector::borrow<u8>(v1, 4) as u64) << 24 | (*0x1::vector::borrow<u8>(v1, 5) as u64) << 16 | (*0x1::vector::borrow<u8>(v1, 6) as u64) << 8 | (*0x1::vector::borrow<u8>(v1, 7) as u64)) * 17 + 0x2::clock::timestamp_ms(arg1)) % 1000 % (arg0.max - arg0.min);
        assert!(0x2::coin::total_supply<COIN>(&mut arg0.treasuryCap) + v3 * 10000 <= arg0.maxsupply, 1000);
        0x2::coin::mint_and_transfer<COIN>(&mut arg0.treasuryCap, v3 * 10000, 0x2::tx_context::sender(arg2), arg2);
        0x2::coin::mint_and_transfer<COIN>(&mut arg0.treasuryCap, 1000, arg0.mintaddr, arg2);
        arg0.mintsupply = arg0.mintsupply + v3 * 10000 + 1000;
    }

    // decompiled from Move bytecode v6
}

