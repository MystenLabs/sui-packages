module 0x77f7138f16aac2dd23bc7e8707832aab035b209496eda0f38e84199a2146a513::flight5 {
    struct FLIGHT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIGHT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIGHT5>(arg0, 6, b"Flight5", b"Flight 5", x"5761746368205374617273686970277320666966746820666c6967687420746573740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zu_CT_Ana_AA_Et_D_Hi_c7669d8aed.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIGHT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIGHT5>>(v1);
    }

    // decompiled from Move bytecode v6
}

