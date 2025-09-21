module 0x18d98c13655b29c91eed58f2bf16d983646ab6b8bcc0a51e117bb299c811da6f::njkl {
    struct NJKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJKL>(arg0, 6, b"Njkl", b"Mnik", b"this is agood coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaxmx44s4cqsn7jqnpe5o5kwsskyxu5wdk53vuqi66gmtz2oolxxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NJKL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

