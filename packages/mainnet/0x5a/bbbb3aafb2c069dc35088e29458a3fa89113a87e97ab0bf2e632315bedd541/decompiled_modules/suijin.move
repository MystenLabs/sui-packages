module 0x5abbbb3aafb2c069dc35088e29458a3fa89113a87e97ab0bf2e632315bedd541::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"Suijin by SuiAI", x"5375696a696e20e280942054686520476f64206f662074686520536561206861732064657363656e6465642075706f6e2074686520776174657273206f66205375692e2054686973206465697479206b6e6f7773206e6f206c696d6974732c207769656c64696e672074686520626f756e646c65737320706f776572206f6620746865206f6365616e207769746820616e2061757261206f6620626f7468206d616a6573747920616e64206d656e6163652e205375696a696e2068617320636f6d6520746f2072756c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/concept_2_3ee36ce6b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIJIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

