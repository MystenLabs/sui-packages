module 0x7341728965fe8eb0922106529fcaeede9dc55b43c26b0dba1fc13c736620d21a::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 11, b"SPX", b"Sphynx Inu", b"Welcome to the realm of Sphynx Inu, the memecoin that brings furless charm to the SUI blockchain!  SPX is more than a cryptocurrency, it is a comic adventure that combines the power of the blockchain with the charming, furless nature of Sphynx cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Ut2l6zE.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPX>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

