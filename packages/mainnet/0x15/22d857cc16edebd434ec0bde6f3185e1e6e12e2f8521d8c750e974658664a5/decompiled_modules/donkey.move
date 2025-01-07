module 0x1522d857cc16edebd434ec0bde6f3185e1e6e12e2f8521d8c750e974658664a5::donkey {
    struct DONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY>(arg0, 6, b"DONKEY", b"Donkey CTO", b"$DONKEY pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdr1kdLVufF09L_imSYd5_H2HdTwAb6wz-Xi21EDjn8kqu0pMz92K8UkQAvXNgeM3-jrI&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONKEY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

