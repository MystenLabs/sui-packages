module 0x5cc6706390bb80460230ff6d0129264797b9a8ab9b5a1549de4a8d52eec91450::pico {
    struct PICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICO>(arg0, 6, b"PICO", b"Pico", b"The signs are clear: penguins thrive in the cold, and $PICO thrives in the chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062998_aa367ae10f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICO>>(v1);
    }

    // decompiled from Move bytecode v6
}

