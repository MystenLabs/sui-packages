module 0x159a80916e048946126eefe14abea86f59c4973ab374d49afaffac59c0e8d6ec::rickey {
    struct RICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKEY>(arg0, 6, b"RICKEY", b"Rickey Sui", b"Hey there, Im Rickey, the raccoon with BIG dreams! While most raccoons are out digging through trash, Im busy exploring the Sui Network, painting masterpieces, teaching classes, and inventing cool stuff. Yep, Im not just any raccoonIm a dreamer, and on Sui, dreams turn into reality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Sjppr_Mu_ZVT_Wj71dayg_NC_6_P6j_EJDM_Qg_Lu4_Lw2u_QPP_Hck_5887313d8d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

