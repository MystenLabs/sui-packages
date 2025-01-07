module 0xe5fc9e023441d186d775729121eeef1232ae857f2207229f6c822bcf31e285ee::kun {
    struct KUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUN>(arg0, 6, b"KUN", b"KunOnSui", b"Hi, I'm $KUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ze_W_Ptm_WIAA_Qs_Bq_4eb5a614f5.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

