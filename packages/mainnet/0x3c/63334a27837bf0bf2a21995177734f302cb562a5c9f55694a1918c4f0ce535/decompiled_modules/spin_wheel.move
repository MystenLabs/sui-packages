module 0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::spin_wheel {
    struct SpinWheelRegistry has key {
        id: 0x2::object::UID,
    }

    struct SpinEvent has copy, drop, store {
        player: address,
        ticket_id: 0x2::object::ID,
        random_value: u8,
        points_earned: u8,
    }

    entry fun spin_wheel(arg0: &mut 0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::quest::QuestRegistry, arg1: &0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::version::Version, arg2: &mut 0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::quest::QuestTicket, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::version::validate_version(arg1, 1);
        0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::quest::validate_quest_status(arg0);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100);
        let v2 = if (v1 < 5) {
            0
        } else if (v1 < 50) {
            1
        } else if (v1 < 80) {
            2
        } else if (v1 < 90) {
            3
        } else if (v1 < 95) {
            9
        } else {
            15
        };
        0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::quest::decrease_ticket_count(arg2);
        0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::quest::add_current_quest_point(arg0, (v2 as u64));
        let v3 = SpinEvent{
            player        : 0x2::tx_context::sender(arg4),
            ticket_id     : 0x2::object::id<0x3c63334a27837bf0bf2a21995177734f302cb562a5c9f55694a1918c4f0ce535::quest::QuestTicket>(arg2),
            random_value  : v1,
            points_earned : v2,
        };
        0x2::event::emit<SpinEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

