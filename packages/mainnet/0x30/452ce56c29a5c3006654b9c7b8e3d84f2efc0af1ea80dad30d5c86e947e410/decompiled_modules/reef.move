module 0x30452ce56c29a5c3006654b9c7b8e3d84f2efc0af1ea80dad30d5c86e947e410::reef {
    public fun on_query_settled<T0, T1>(arg0: &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::Query<T0>, arg1: 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::QuerySettled, arg2: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::Market<T1>, arg3: &0x2::clock::Clock) {
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::query_settled_query_id(&arg1) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::id<T0>(arg0), 1);
        assert!(0x1::option::some<0x2::object::ID>(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::query_settled_query_id(&arg1)) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::oracle_id<T1>(arg2), 1);
        0x30452ce56c29a5c3006654b9c7b8e3d84f2efc0af1ea80dad30d5c86e947e410::coral::resolve_market_<T1>(arg2, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::query_settled_data(&arg1), arg3);
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::verify_query_settled<0x30452ce56c29a5c3006654b9c7b8e3d84f2efc0af1ea80dad30d5c86e947e410::coral::CoralWitness>(arg1, 0x30452ce56c29a5c3006654b9c7b8e3d84f2efc0af1ea80dad30d5c86e947e410::coral::witness());
    }

    // decompiled from Move bytecode v6
}

