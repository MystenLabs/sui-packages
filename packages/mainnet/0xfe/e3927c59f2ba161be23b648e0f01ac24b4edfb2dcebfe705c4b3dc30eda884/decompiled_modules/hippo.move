module 0xfee3927c59f2ba161be23b648e0f01ac24b4edfb2dcebfe705c4b3dc30eda884::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"Hippo", b"Hipppoo", b"that the hippo is dangers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x8993129d72e733985f7f1a00396cbd055bad6f817fee36576ce483c8bbb8b87b_sudeng_sudeng_a6070b55af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

