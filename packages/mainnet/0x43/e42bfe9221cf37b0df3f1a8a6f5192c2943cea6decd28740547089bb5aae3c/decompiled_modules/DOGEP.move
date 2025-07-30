module 0x43e42bfe9221cf37b0df3f1a8a6f5192c2943cea6decd28740547089bb5aae3c::DOGEP {
    struct DOGEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEP>(arg0, 6, b"DogePrime", b"DOGEP", b"The ultimate evolution of the Doge meme coin, combining the charm of the original Shiba Inu with next-level meme magic. DogePrime is the alpha dog of crypto, bringing humor, community, and moon missions to the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/shFj5Njs135VDRcRnNuX398r3k8VuWvZTcv8VphGfEgJvfFVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEP>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

