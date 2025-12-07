module 0xf9f31e0b26ca42263a68f27d8c28642baeac6d6810ef2d79a211c2d0ef6ad7f5::reef {
    public fun on_query_settled<T0, T1>(arg0: &0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::Query<T0>, arg1: 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::callback::QuerySettled, arg2: &mut 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::Market<T1>, arg3: &0x2::clock::Clock) {
        assert!(0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::callback::settled_query_id(&arg1) == 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::id<T0>(arg0), 1);
        assert!(0x1::option::some<0x2::object::ID>(0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::callback::settled_query_id(&arg1)) == 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::oracle_id<T1>(arg2), 1);
        0xf9f31e0b26ca42263a68f27d8c28642baeac6d6810ef2d79a211c2d0ef6ad7f5::coral::resolve_market<T1>(arg2, 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::callback::settled_data(&arg1), arg3);
        0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::callback::verify_query_settled<0xf9f31e0b26ca42263a68f27d8c28642baeac6d6810ef2d79a211c2d0ef6ad7f5::coral::CoralWitness>(arg1, 0xf9f31e0b26ca42263a68f27d8c28642baeac6d6810ef2d79a211c2d0ef6ad7f5::coral::witness());
    }

    // decompiled from Move bytecode v6
}

