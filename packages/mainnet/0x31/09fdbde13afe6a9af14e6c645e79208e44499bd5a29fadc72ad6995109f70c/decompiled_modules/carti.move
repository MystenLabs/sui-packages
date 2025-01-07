module 0x3109fdbde13afe6a9af14e6c645e79208e44499bd5a29fadc72ad6995109f70c::carti {
    struct CARTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTI>(arg0, 9, b"CARTI", b"PLAYBOI CARTI", b"PLAYBOI CARTI real token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CARTI>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

