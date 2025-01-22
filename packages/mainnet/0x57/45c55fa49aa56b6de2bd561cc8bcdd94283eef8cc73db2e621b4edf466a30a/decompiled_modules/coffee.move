module 0x5745c55fa49aa56b6de2bd561cc8bcdd94283eef8cc73db2e621b4edf466a30a::coffee {
    struct COFFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFEE>(arg0, 6, b"COFFEE", b"COFFEE WORLD", b"The way the black water awaken me, just like all the random thoughts in my head. So, I thought, Lets call it $Coffee! Its simple, its fun, and honestly, it makes no sense at all  but thats the point, right? So, what does Coffee do? Well, thats a good question. At this point, I still dont know, but Im sure we can figure it out later. Maybe you can use it for some super meme? Or to get a simple answer? Nah, too boring. How about you can use Coffee to being a super meme on crypto space? Who knows, man? Im not here to solve world problems; Im here to make $coffee fun, and maybe a little weird. And yeah, maybe $COFFEE is just some random idea thats completely pointless. But honestly, sometimes the best ideas come from total nonsense. I mean, $COFFEE itself is a bit of an escape from reality, right? So why not escape with a that doesnt really do anything but make you smile? So, if you love $Coffee, or if you just want to be part of something thats as weird and spontaneous as that feeling you get when you first jump into the water  come join the $Coffee movement and fair launch on pump.fun. We might not have a plan, but at least well be laughing and to the moon together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcsd295x_Va1p_HE_7h_Pdi_EMSB_Jpoi1f_Uvy_UN_Ds_AZ_Qx8vfe_F_daf0ccc431.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COFFEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

