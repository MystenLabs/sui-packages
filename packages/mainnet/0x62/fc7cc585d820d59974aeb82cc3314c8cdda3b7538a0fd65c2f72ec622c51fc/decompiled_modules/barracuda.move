module 0x62fc7cc585d820d59974aeb82cc3314c8cdda3b7538a0fd65c2f72ec622c51fc::barracuda {
    struct BARRACUDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRACUDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRACUDA>(arg0, 6, b"CUDA", b"Barracuda", b"A barracuda is a large, predatory, ray-finned fish known for its fearsome appearance and ferocious behaviour.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/csJhd8R.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARRACUDA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARRACUDA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BARRACUDA>>(v2);
    }

    // decompiled from Move bytecode v6
}

