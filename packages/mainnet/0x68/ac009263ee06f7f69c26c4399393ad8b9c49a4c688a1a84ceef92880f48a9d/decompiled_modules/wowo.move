module 0x68ac009263ee06f7f69c26c4399393ad8b9c49a4c688a1a84ceef92880f48a9d::wowo {
    struct WOWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWO>(arg0, 9, b"WOWO", b"Txn", b"Meme happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1242c855-d702-43e1-8ec2-3b282b8a5b29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

