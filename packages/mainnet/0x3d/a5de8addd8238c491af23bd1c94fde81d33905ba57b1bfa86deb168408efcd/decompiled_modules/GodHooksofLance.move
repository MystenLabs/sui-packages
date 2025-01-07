module 0x3da5de8addd8238c491af23bd1c94fde81d33905ba57b1bfa86deb168408efcd::GodHooksofLance {
    struct GODHOOKSOFLANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODHOOKSOFLANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODHOOKSOFLANCE>(arg0, 0, b"COS", b"GodHooks of Lance", b"Dusty talons of you fell giants... cling to me...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_GodHooks_of_Lance.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODHOOKSOFLANCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODHOOKSOFLANCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

