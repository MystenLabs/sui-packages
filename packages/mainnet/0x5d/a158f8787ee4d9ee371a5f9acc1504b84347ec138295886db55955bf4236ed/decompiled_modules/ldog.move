module 0x5da158f8787ee4d9ee371a5f9acc1504b84347ec138295886db55955bf4236ed::ldog {
    struct LDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDOG>(arg0, 9, b"LDOG", b"Lost Dogs ", x"4a6f696e20746865207061636b2077697468204c6f7420446f67732c2074686520756c74696d617465206d656d65636f696e2e0a556e6c656173682063727970746f63757272656e6379277320706c617966756c20736964652077697468206f757220636f6d6d756e6974792d64726976656e2070726f6a6563742e0a456d706f776572696e6720646f67206c6f7665727320616e642063727970746f20656e74687573696173747320776f726c64776964652e0a466574636820796f7572207368617265206e6f7720616e64207374617274206261726b696e672075702074686520726967687420747265652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f49a0002-c782-4066-bf17-1054da74ad7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

