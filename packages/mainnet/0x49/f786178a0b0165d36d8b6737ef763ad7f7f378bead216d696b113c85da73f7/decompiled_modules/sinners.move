module 0x49f786178a0b0165d36d8b6737ef763ad7f7f378bead216d696b113c85da73f7::sinners {
    struct SINNERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINNERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINNERS>(arg0, 9, b"SINNERS", b"Sinners", b"Trying to leave their troubled lives behind, twin brothers (Jordan) return to their hometown to start again, only to discover that an even greater evil is waiting to welcome them back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/SINNERS.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SINNERS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINNERS>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINNERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

