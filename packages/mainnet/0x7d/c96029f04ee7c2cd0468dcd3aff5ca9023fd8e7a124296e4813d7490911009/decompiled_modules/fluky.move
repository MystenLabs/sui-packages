module 0x7dc96029f04ee7c2cd0468dcd3aff5ca9023fd8e7a124296e4813d7490911009::fluky {
    struct FLUKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUKY>(arg0, 9, b"FLUKY", b"We Lucky's", b"A cryptocurrency whose images are based on memes from the Internet. This is a digital asset that exists only on the Internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1091d667-bfd2-447e-8ddb-c2ebd1b313cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

