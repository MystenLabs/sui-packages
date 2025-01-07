module 0xb207912a3d97c3b9b8409d577242bd6dcf0892e6b3880b55e66ab0839ec33c2f::mother {
    struct MOTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTHER>(arg0, 6, b"MOTHER", b"Sui Mother", b"The nurturing force of the Sui Network.  $SUIMOTHER cares for her own, guiding and protecting the community with wisdom and strength. A true guardian, shes the heart of Sui, ensuring we all thrive together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOTHER_1_490c9f3d63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

