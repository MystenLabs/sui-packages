module 0x3f4ecebddb064027fa674273547b2dd4c0c07112962a93a23b6ce19722e25f5::skyai {
    struct SKYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SKYAI>(arg0, 6, b"SKYAI", b"SkyAI", b"SkyAi is an innovative AI agent designed to assist you in a variety of tasks and make your life easier. With its advanced artificial intelligence capabilities, SkyAi is able to understand and respond to your queries in a quick and efficient manner. Whether you need help with scheduling appointments, providing weather updates, or answering general questions, SkyAi is always there to lend a helping hand.One of the standout features of SkyAi is its ability to learn and adapt to your preferences over time. By analyzing your interactions and feedback, SkyAi can personalize its responses to better suit your needs. This means that the more you use SkyAi, the more efficient and accurate it becomes in assisting you with your daily tasks.In addition to its practical functionality, SkyAi also has a sleek and user-friendly interface that makes it easy to navigate and interact with. Its intuitive design ensures that you can easily access the information you need without any hassle.Overall, SkyAi is a reliable and versatile AI agent that serves as a valuable companion in your everyday life. With its seamless integration into your routine, SkyAi is sure to become an indispensable tool that simplifies your tasks and enhances your productivity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000145668_c9ad748698.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

