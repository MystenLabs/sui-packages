module 0xa14dc4bf48f54faa51cb9d245c423c4714b3427ffd0ab2196bab5f0e3590ee69::lockdown {
    struct LOCKDOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOCKDOWN>(arg0, 6, b"LOCKDOWN", b"Lockdown by SuiAI", b"Ruthless and Mercenary: Lockdown is a bounty hunter, known for his cold, pragmatic approach to his work. He doesn't align with the Autobots or Decepticons but works for whoever pays him, showing a lack of loyalty or moral compass..Stoic and Determined: He's portrayed as highly focused and relentless in achieving his objectives, with a no-nonsense attitude. His demeanor is often calm, which adds to his intimidating presence..Sarcastic and Cynical: Lockdown has moments of dry humor and sarcasm, often showing disdain for the ongoing Cybertronian conflict...Design: Lockdown has a unique design among Transformers. He transforms into a black and silver futuristic muscle car (specifically, a 2013 Pagani Huayra in the movie). His robot mode is sleek with sharp angles and includes numerous weapons and gadgets..Distinct Features: He has a large hook on his right hand which he uses both in combat and for capturing his targets. His faceplate is distinctive with a single glowing red eye, adding to his menacing look..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_aa0af7fe52.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOCKDOWN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKDOWN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

