module 0x9735e6fd57c2f5eff280519cc463d0a2d6bb9b3104aaa2a380e356b69e865fad::lilboy {
    struct LILBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILBOY>(arg0, 6, b"LILBOY", b"Lil Boy by Matt Furie!", x"54686572652068617665206265656e2072756d6f7273206f662068696d206265696e6720666f7263656420696e746f207468697320736974756174696f6e20627920736f6d6520756e6b6e6f776e20656e7469747920616e6420616e796f6e652077686f20646172656420746f20646976652064656570657220696e746f206974206469736170706561727320746865206e657874206461792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lilboy_519a76c8c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

