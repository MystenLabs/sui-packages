module 0x204d9163f25d8204540b676c9c19c3e6fa1300a4a9e94167010f7426d4210087::den {
    struct DEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEN>(arg0, 9, b"DEN", b"denys", b"denys the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b6b0c73059343bcf44ec17ea48915e3cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

