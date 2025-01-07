module 0xfc98ceb3d0a9c9b5a1c5bd106fed184b4143409a2467c9bbf20a2e3fdd5a8e61::grinch {
    struct GRINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCH>(arg0, 6, b"Grinch", b"GrinchSui", b"The Grinch is depicted as a green, furry, pot-bellied, pear-shaped, snub-nosed humanoid creature with a cat-like face and cynical personality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F2_J_Lbza_A8tav_G_Np_JSY_Gin_Xth3_JEB_8xr_PX_Dw_J78s_Tpump_3aaa48ba8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

