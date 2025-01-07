module 0xf360e32a367f0b069d6eee4462c67d69f720ec762fabfa27b97d52cbabce1ebf::pignuts {
    struct PIGNUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGNUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGNUTS>(arg0, 6, b"PIGNUTS", b"Diana's Guinea Pig", x"4265666f72652054696b546f6b20616e6420496e7374616772616d2c20746865726520776173205065616e75747320616e64205072696e63657373204469616e610a0a245049474e5554533a20546865206f6e6c7920696e766573746d656e7420746861742067756172616e7465657320637564646c657320616e6420726f79616c20737461747573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731499758810.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIGNUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGNUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

