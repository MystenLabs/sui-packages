module 0x862a87daab4d07648aa89bb3666de0109b7dfa05293fa87d49baaf96a98e67fe::woc {
    struct WOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOC>(arg0, 6, b"WOC", b"Wolf Of Crypto!", b"We have all heard of wolf of wall street but who is the wolf of crypto? Will you be the Wolf Crypto? Prove you are the wolf of crypto by joining the upcoming pack as we Load And Hold our WOC and become the wolves of crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WOC_TP_Lbb_B_Pe_Yj_Uu2_Xp_Zod_d2eba80d90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

