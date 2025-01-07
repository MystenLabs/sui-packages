module 0x85b237b88adbd224e14a203971991a53e281e6ff9d495b896ea97b8f5d1eb59b::lba {
    struct LBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBA>(arg0, 9, b"LBA", b"Libra", x"42616c616e636520796f757220706f7274666f6c696f2077697468204c69627261436f696e3a205468652063727970746f63757272656e63792074686174207363616c6573206e65772068656967687473207768696c65206d61696e7461696e696e6720657175696c69627269756d2c206f66666572696e67206661697220616e6420737461626c65206761696e7320696e207468652063727970746f20756e6976657273652120e29a96efb88f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87df219d-8c86-4323-be66-c99c5a649465.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

