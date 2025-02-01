module 0x28b37a5cf3f608eea6c5c0ab4ddfe4b7479e09bf364ff0527852628530dbd083::sds {
    struct SDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDS>(arg0, 6, b"SDS", b"ShelldonSui", b"Welcome to Shelldon! Let's explore the fun and potential of the Suinetwork world together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_f08b0a60cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

