module 0x69180fac72b67779cecb67e95f76dffbba4353a0c15a8f224c1149a682d3a72b::p3pe {
    struct P3PE has drop {
        dummy_field: bool,
    }

    struct WappredTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<P3PE>,
    }

    struct Burned has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut WappredTreasury, arg1: 0x2::coin::Coin<P3PE>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Burned{
            amount : 0x2::coin::burn<P3PE>(&mut arg0.treasury_cap, arg1),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burned>(v0);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<P3PE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<P3PE>>(arg0, arg1);
    }

    fun init(arg0: P3PE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P3PE>(arg0, 6, b"P3PE", b"P3PE Hacker", b"hacker token made by hackers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibz774ssbuh4bx67rmw7mrdz3f4kdrtteczno2seoep3pfe44rbuq")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P3PE>>(v1);
        0x2::coin::mint_and_transfer<P3PE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = WappredTreasury{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::share_object<WappredTreasury>(v3);
    }

    // decompiled from Move bytecode v6
}

