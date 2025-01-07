module 0x826e190b177a2880447ddfd3cda67f2dd517eb38d0265584534a4e8e01ffe7a8::grinch {
    struct GRINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCH>(arg0, 6, b"GRINCH", b"Grinch On Sui", b"The Grinch is a green, furry, pot-bellied, pear-shaped, snub-nosed humanoid with a cat-like face and a cynical attitude.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_7_Bh_KC_Xk_A_Eg1n_M_c2405cf280.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

