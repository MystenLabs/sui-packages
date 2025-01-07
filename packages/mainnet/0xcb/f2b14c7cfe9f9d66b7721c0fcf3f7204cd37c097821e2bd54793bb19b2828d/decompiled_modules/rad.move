module 0xcbf2b14c7cfe9f9d66b7721c0fcf3f7204cd37c097821e2bd54793bb19b2828d::rad {
    struct RAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAD>(arg0, 9, b"RAD", b"RADICal", b"Radiating Fun, One Block at a Time. A Fun, Gaming, and Community Engagement. RAD aims to capture the spirit of enjoying cryptocurrency, with a focus on gaming integrations and community-driven projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b6b9007ef7cf5e2b5c3431e9dfb2ac79blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

