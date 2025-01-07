module 0x80500fb61bb12bcbc6b9e916efca0136f782e95ed0ce4651ba08ecb849392e34::smetra {
    struct SMETRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMETRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMETRA>(arg0, 6, b"SMETRA", b"SUIMETRA", x"5355494d45545241202824534d4554524129206973206865726520746f206272696e6720746865204f766572776174636820766962657320746f207468652053756920626c6f636b636861696e2120496d6167696e6520796f7572206661766f72697465206865726f6573206d656574696e672074686520776f726c64206f662057656233e2809424534d45545241206973206d616b696e672069742068617070656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732063970204.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMETRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMETRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

