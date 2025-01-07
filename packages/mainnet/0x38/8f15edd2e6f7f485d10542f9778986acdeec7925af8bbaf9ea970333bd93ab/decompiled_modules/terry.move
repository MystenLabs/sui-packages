module 0x388f15edd2e6f7f485d10542f9778986acdeec7925af8bbaf9ea970333bd93ab::terry {
    struct TERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERRY>(arg0, 6, b"TERRY", b"Terry In The Sui Trenches", b"Hey, I'm a little turtle working on pumping your bags on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Terry_4a7da30e0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

