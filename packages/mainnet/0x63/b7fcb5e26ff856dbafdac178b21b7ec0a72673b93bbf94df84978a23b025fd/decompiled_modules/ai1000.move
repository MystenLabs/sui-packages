module 0x63b7fcb5e26ff856dbafdac178b21b7ec0a72673b93bbf94df84978a23b025fd::ai1000 {
    struct AI1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI1000>(arg0, 9, b"AI1000", b"AI1000 Token", b"AI possesses the capability to independently manage a fund established by a leading-edge framework.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public.daossui.io/dao-sui/assets/AI1000-token.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AI1000>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI1000>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI1000>>(v1);
    }

    // decompiled from Move bytecode v6
}

