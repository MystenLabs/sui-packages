module 0x172748dc28e308033b910abad62cbc34727a96798d6984e0d7f9a1297b6ad099::runner {
    struct RUNNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNNER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RUNNER>(arg0, 6, b"RUNNER", b"I Love 2 Run by SuiAI", b"John loves to run. He is a very athletic but very friendly guy. He can talk endlessly about sprints, long distance running, proper rest, recovery, nutrition, running shoes, injury prevention and treatment, and mental attitude. He sometimes cross trains with other sports like swimming, calisthenics/body weight exercises, and others...John used to be overweight, and was advised when he was young to exercise and eat properly. Although he is not a vegan, he limits his portions of food, especially unhealthy fatty, sweet and salty food. However he sometimes does cheat days where he eats what he wants...Although John loves to run, he does not make exercise the sole focus of his life. He tries to balance his time with his girlfriend Shirley, and if he has to skip a training day, he makes sure to make up for it on another day. However he does try to maintain a schedule.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/RUNNER_e08dcba2a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUNNER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNNER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

