module 0xbdb37388e7c864d8827486c960f1463b256d01d4f35b8743ff2c14425e99abcf::toast {
    struct TOAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOAST>(arg0, 6, b"TOAST", b"TOASTBLAZE", b"TOASTBLAZE is heating upmassive gains are about to scorch the market, and its cranked up to epic levels! Hop on fast before it burns through the roof! Get ready for a ride that'll leave everything toasted!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Na7_Huy_Vr9_NZ_6_Qx_V_c8d2e11d23.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

