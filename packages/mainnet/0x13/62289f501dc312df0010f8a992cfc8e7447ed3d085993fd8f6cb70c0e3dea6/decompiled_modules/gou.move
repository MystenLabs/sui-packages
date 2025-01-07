module 0x1362289f501dc312df0010f8a992cfc8e7447ed3d085993fd8f6cb70c0e3dea6::gou {
    struct GOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOU>(arg0, 6, b"GOU", b"GoU", b"My name is Gou , It's Chinese for Dog! My mom Neiro tells me to dream big, so that one day I can be just like my uncle, Doge!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOU_TS_Lik_L_0_RMDI_4_JZR_Az0_0f61313cd4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

