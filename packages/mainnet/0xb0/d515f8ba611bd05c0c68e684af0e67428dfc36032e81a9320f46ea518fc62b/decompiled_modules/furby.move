module 0xb0d515f8ba611bd05c0c68e684af0e67428dfc36032e81a9320f46ea518fc62b::furby {
    struct FURBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURBY>(arg0, 6, b"FURBY", b"Furby", x"467572627920287469636b65723a204675726279290a467572627920697320616e20416d65726963616e20656c656374726f6e696320726f626f74696320746f792e204f726967696e616c6c792072656c656173656420696e203139393820697420726573656d626c657320612068616d73746572206f72206f776c206c696b65206372656174757265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rt_ZJ_Fcg_T_Tf_H36ue9q_V8_Xhhv_XS_9d1prox_Djgan8_Qsyi_G5_d6ad5fe345.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

