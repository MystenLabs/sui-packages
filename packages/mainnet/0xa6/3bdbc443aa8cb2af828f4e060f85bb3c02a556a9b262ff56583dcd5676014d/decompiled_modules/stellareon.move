module 0xa63bdbc443aa8cb2af828f4e060f85bb3c02a556a9b262ff56583dcd5676014d::stellareon {
    struct STELLAREON has drop {
        dummy_field: bool,
    }

    fun init(arg0: STELLAREON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STELLAREON>(arg0, 9, b"STELLAREON", b"pupes", b"Meme pups\" refers to adorable puppies that have become shared across social media  caught in a goofy moment or paired with humorous captions, meme pups bring joy and laughter ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dca525c5-ba15-46c6-b727-6226843f5437.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STELLAREON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STELLAREON>>(v1);
    }

    // decompiled from Move bytecode v6
}

