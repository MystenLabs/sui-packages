module 0x7c393cdbfed9671dd5bc87d6de9905ee146e5e119f2b7cf9cc89fc836a01b26e::defi6900 {
    struct DEFI6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFI6900>(arg0, 6, b"DEFI6900", b"DogExplodeFundIndex6900", b"it's DEFI6900 at SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SF_2_H_Huzq_Ra5bd1_Qnzi_Wo68_H8t_Dycn_L99w8x_KTHBH_7bw_Q_95d33159ea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFI6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEFI6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

