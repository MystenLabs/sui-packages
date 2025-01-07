module 0x243ccb83eb01f7edfd40fb357737f49a74805453c6832636e950fa8f7561689b::suicati {
    struct SUICATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATI>(arg0, 9, b"SUICATI", b"SUICAT", b"SUICAT is crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c79d543-5cf3-481c-b6fe-a721eda6552b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

