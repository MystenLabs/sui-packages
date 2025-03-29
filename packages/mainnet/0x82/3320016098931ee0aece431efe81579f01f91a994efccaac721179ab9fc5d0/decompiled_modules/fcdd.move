module 0x823320016098931ee0aece431efe81579f01f91a994efccaac721179ab9fc5d0::fcdd {
    struct FCDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCDD>(arg0, 9, b"FCDD", b"FC DNIPRO", b"FC DNIPRO fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1e60f4431bd0382fb6f1727bb1653b3cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

