module 0x3fddefaf52a82175ccdf4c8136648100739baf984c0c96f3bdfdce832a5f838a::cluckey {
    struct CLUCKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUCKEY>(arg0, 6, b"CLUCKEY", b"SUCLUCK", b"SuCluck isn't just about gobbling up gains; he's all about spreading the wealth and educating fellow fowls on the benefits of decentralization and financial freedom. Whether it's Thanksgiving or not, SuCluck is here to make sure everyone gets their slice of the crypto pie!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/turkey_1157222ed8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUCKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUCKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

