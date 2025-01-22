module 0x3adb0e64ba0ff0ee743cf0ad1f292711daa488824859113e15ceaa03cb2de08b::mtc {
    struct MTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTC>(arg0, 9, b"MTC", b"Mala Cat", b"Mala the cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23fd014f-f6b1-41bc-8e39-07c97b685510.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

