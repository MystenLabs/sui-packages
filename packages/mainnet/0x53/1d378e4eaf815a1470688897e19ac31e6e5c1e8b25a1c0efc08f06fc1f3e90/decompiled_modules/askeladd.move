module 0x531d378e4eaf815a1470688897e19ac31e6e5c1e8b25a1c0efc08f06fc1f3e90::askeladd {
    struct ASKELADD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASKELADD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASKELADD>(arg0, 6, b"Askeladd", b"Askeladd VilandSaga", b"Haven't you given a thought... To what you're going to live for... After I'm dead, Thorfinn? Ha Ha... You haven't, have you? You're hopeless, you know that? Move on, Thorfinn. Don't hang on... To this petty bullshit your entire life... You've got to move on... Go further... You are the son of Thors... So, venture beyond the world he saw. That is...your true battle. Be a true warrior... son of... Thors. Askeladd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thorfinn_profile_image_3_F1014_29_a1f3d02ab2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASKELADD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASKELADD>>(v1);
    }

    // decompiled from Move bytecode v6
}

