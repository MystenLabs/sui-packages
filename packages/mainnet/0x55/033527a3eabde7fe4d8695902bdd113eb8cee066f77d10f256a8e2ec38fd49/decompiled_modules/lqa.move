module 0x55033527a3eabde7fe4d8695902bdd113eb8cee066f77d10f256a8e2ec38fd49::lqa {
    struct LQA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LQA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LQA>(arg0, 9, b"LQA", b"Liquid Arc", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/638a6edcb73f209086ede9a4a4aff7dablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LQA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LQA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

