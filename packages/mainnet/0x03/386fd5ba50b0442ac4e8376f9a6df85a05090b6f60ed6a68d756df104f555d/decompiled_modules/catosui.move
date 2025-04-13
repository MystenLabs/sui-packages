module 0x3386fd5ba50b0442ac4e8376f9a6df85a05090b6f60ed6a68d756df104f555d::catosui {
    struct CATOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATOSUI>(arg0, 9, b"CATOSUI", b"SUICATO", b"CATO ON SUI ARE YOU JOIN CATO ARMY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/32b61b19eca987786532f63ca69da30ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

