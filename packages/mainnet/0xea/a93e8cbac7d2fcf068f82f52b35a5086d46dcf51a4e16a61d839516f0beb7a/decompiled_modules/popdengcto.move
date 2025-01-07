module 0xeaa93e8cbac7d2fcf068f82f52b35a5086d46dcf51a4e16a61d839516f0beb7a::popdengcto {
    struct POPDENGCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENGCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENGCTO>(arg0, 6, b"POPDENGCTO", b"CTO ON POPDENG", x"4341203a203078366163336236303132636534396336366339306464633165643666326533376230613536653164336236363863313065396232383861656338353833376562323a3a706f70643a3a504f50440a0a444f4e2774206170652074686973206f6e6520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POOOPDE_Ng_614e9dd20d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENGCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENGCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

