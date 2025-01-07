module 0xc03ad762897162de53dc64eb7df4d8fbfd977296b8c30dbae1c706229460267b::krk {
    struct KRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRK>(arg0, 6, b"Krk", b"krakensui", b"The whales have woken up the Kraken.  The king of the Sea. No fish is safe, the seas are rough and full of chaos. It is time for degens to sui the king to the top.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AC_8_BB_1_A3_DD_27_4_F9_A_8_AB_5_A25507_AA_52_EC_1_100_o_cc8882fdf1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

