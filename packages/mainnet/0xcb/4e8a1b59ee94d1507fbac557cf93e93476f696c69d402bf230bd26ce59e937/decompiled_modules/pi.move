module 0xcb4e8a1b59ee94d1507fbac557cf93e93476f696c69d402bf230bd26ce59e937::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 0, b"PI", b"PI", b"Pedia AI Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/xtXRSzbP/Resizer-17398172260741.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PI>>(v1);
    }

    // decompiled from Move bytecode v6
}

