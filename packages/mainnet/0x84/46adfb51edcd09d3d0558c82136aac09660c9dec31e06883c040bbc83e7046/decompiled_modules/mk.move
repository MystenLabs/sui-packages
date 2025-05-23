module 0x8446adfb51edcd09d3d0558c82136aac09660c9dec31e06883c040bbc83e7046::mk {
    struct MK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MK>(arg0, 9, b"MK", b"MINA KITANO", b"MINA KITANO FANS BASE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/72141d1f42705c4109d062c3d5ed8db4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

