module 0x58e4f55f52b00c28796e8f328235ef14f08892451c86d99ce059b82563bcf1b7::pg {
    struct PG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PG>(arg0, 9, b"PG", b"pingvi", b"kinder pingvi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4170976fb51c6ea707860bb359b07fe5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

