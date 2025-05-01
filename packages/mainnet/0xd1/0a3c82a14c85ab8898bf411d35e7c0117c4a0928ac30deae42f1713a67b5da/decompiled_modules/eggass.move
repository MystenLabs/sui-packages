module 0xd10a3c82a14c85ab8898bf411d35e7c0117c4a0928ac30deae42f1713a67b5da::eggass {
    struct EGGASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGASS>(arg0, 6, b"EGGASS", b"EGGCELLENT ASS", b"Were the wobbly little eggs with the goofiest asses, rolling into the meme world with pure mischief and charm! Born to wiggle, wobble, and stir up some fun, we crack the normnever breaking, just bouncing back cuter than ever. No boring coins, no empty hypejust endless giggles, creativity, and a world where memes hatch into something egg-straordinary!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eggpp_c9df023a74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

