module 0x8eb73900d7adff38d15ed4bbd0ecff360ba50a20adcd79a46ca6e7ede5d6c682::suidonk {
    struct SUIDONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDONK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIDONK>(arg0, 6, b"SUIDONK", b"Donkey Ai by SuiAI", b"it is an donkey but a godly ass. it has all the knowledge in the sui ecosystem, it is a donkey but a hardworking donkey, it is also a playful donkey and a wise donkey. A fantastic donkey that is unique in the cryptocurrency ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/esekaiaiai_58b18bbcbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDONK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDONK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

