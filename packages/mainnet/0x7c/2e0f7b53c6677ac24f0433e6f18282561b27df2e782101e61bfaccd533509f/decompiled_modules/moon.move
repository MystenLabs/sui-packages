module 0x7c2e0f7b53c6677ac24f0433e6f18282561b27df2e782101e61bfaccd533509f::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"SUI MOON", x"534d4f4f4e20697320616e20616c69656e206361742074686174207761732073656e74206f6e2061206d697373696f6e20746f20726574726965766520696e666f726d6174696f6e2066726f6d20706c616e65742065617274682c20686f776576657220686520637261736865642068697320737061636563726166742075706f6e206172726976616c20616e6420686173206e6f20776179206261636b20686f6d652068656c702075732066696e642068697320776179206261636b20746f20746865204d6f6f6e21200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_81_69e585ee0d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

